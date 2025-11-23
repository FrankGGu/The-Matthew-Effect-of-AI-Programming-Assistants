#include <stdlib.h> // For malloc, free
#include <string.h> // For strcmp

#define HASH_TABLE_SIZE 200003 

typedef struct SenderEntry {
    const char* name; // Pointer to the original sender string from the input array
    int wordCount;
    struct SenderEntry* next; // Pointer for separate chaining in case of hash collisions
} SenderEntry;

SenderEntry* hashTable[HASH_TABLE_SIZE];

unsigned int hash(const char* str) {
    unsigned int h = 0;
    while (*str) {
        h = (h * 31) + (*str); // Multiplier 31 is a common choice
        str++;
    }
    return h % HASH_TABLE_SIZE; // Ensure the hash fits within table bounds
}

int countWords(const char* message) {
    int count = 0;
    // Handle null or empty messages
    if (message == NULL || *message == '\0') {
        return 0;
    }

    int inWord = 0; // Flag to track if currently inside a word
    while (*message) {
        if (*message == ' ') {
            inWord = 0; // Reset flag if a space is encountered
        } else { // Character is not a space
            if (inWord == 0) { // If not currently in a word, this is the start of a new one
                inWord = 1;
                count++;
            }
        }
        message++; // Move to the next character
    }
    return count;
}

SenderEntry* getOrCreateSenderEntry(const char* senderName) {
    unsigned int index = hash(senderName); // Get the hash bucket index
    SenderEntry* current = hashTable[index];

    // Traverse the linked list at the bucket to find if the sender already exists
    while (current != NULL) {
        if (strcmp(current->name, senderName) == 0) { // Compare sender names
            return current; // Found existing entry
        }
        current = current->next;
    }

    // If sender not found, create a new entry
    SenderEntry* newEntry = (SenderEntry*)malloc(sizeof(SenderEntry));
    // Store the pointer to the original senderName string. No need to strdup.
    newEntry->name = senderName; 
    newEntry->wordCount = 0; // Initialize word count to 0
    // Add the new entry to the beginning of the linked list in the bucket
    newEntry->next = hashTable[index]; 
    hashTable[index] = newEntry;

    return newEntry;
}

char* largestWordCount(char** messages, int messagesSize, char** senders, int sendersSize) {
    // IMPORTANT: Clear the hash table before processing. This is crucial if the function
    // is called multiple times in a test suite (common in LeetCode for global variables).
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        SenderEntry* current = hashTable[i];
        while (current != NULL) {
            SenderEntry* temp = current;
            current = current->next;
            free(temp); // Free the SenderEntry struct
        }
        hashTable[i] = NULL; // Reset bucket pointer to NULL
    }

    // Iterate through all messages and senders to populate word counts in the hash table.
    for (int i = 0; i < messagesSize; i++) {
        const char* currentSenderName = senders[i];
        const char* currentMessage = messages[i];

        int words = countWords(currentMessage); // Count words in the current message
        SenderEntry* entry = getOrCreateSenderEntry(currentSenderName); // Get or create sender entry
        entry->wordCount += words; // Add words to sender's total count
    }

    // After processing all messages, find the sender with the largest word count.
    char* bestSender = NULL; // Stores the name of the sender with the largest count
    int maxWordCount = -1; // Stores the maximum word count found so far

    // Iterate through the hash table to find the best sender
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        SenderEntry* current = hashTable[i];
        while (current != NULL) {
            // If current sender has more words, update maxWordCount and bestSender
            if (current->wordCount > maxWordCount) {
                maxWordCount = current->wordCount;
                // Cast to char* is safe as current->name points to an original char* from input
                bestSender = (char*)current->name; 
            } else if (current->wordCount == maxWordCount) {
                // If word counts are equal, compare sender names lexicographically.
                // Choose the one that comes lexicographically *last* (larger string).
                // strcmp returns > 0 if current->name is lexicographically greater than bestSender.
                if (bestSender == NULL || strcmp(current->name, bestSender) > 0) {
                    bestSender = (char*)current->name;
                }
            }
            current = current->next; // Move to the next entry in the linked list
        }
    }

    return bestSender; // Return the name of the sender
}