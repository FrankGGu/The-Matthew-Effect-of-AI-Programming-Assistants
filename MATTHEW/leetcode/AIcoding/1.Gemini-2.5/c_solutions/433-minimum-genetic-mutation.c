#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

bool differsByOne(const char* s1, const char* s2) {
    int diff_count = 0;
    for (int i = 0; i < 8; ++i) {
        if (s1[i] != s2[i]) {
            diff_count++;
        }
    }
    return diff_count == 1;
}

int minMutation(char* startGene, char* endGene, char** bank, int bankSize) {
    if (strcmp(startGene, endGene) == 0) {
        return 0;
    }

    // Maximum number of unique genes: bankSize (max 10) + 1 (for startGene if not in bank)
    // So, MAX_NODES will be at most 11.
    const int MAX_NODES = bankSize + 1; 
    char all_genes[MAX_NODES][9]; // Stores all unique genes (8 chars + null terminator)
    int num_all_genes = 0;

    int start_idx = -1;
    int end_idx = -1;

    // Add startGene to our list of all_genes
    strcpy(all_genes[num_all_genes], startGene);
    start_idx = num_all_genes;
    num_all_genes++;

    // Add genes from bank to all_genes, ensuring uniqueness
    for (int i = 0; i < bankSize; ++i) {
        bool found = false;
        for (int j = 0; j < num_all_genes; ++j) {
            if (strcmp(bank[i], all_genes[j]) == 0) {
                found = true;
                break;
            }
        }
        if (!found) {
            strcpy(all_genes[num_all_genes], bank[i]);
            num_all_genes++;
        }
    }

    // Find the index of endGene in our all_genes list
    for (int i = 0; i < num_all_genes; ++i) {
        if (strcmp(endGene, all_genes[i]) == 0) {
            end_idx = i;
            break;
        }
    }

    // If endGene is not found in the bank (or startGene itself), it's unreachable
    if (end_idx == -1) {
        return -1;
    }

    // BFS setup
    int queue[MAX_NODES];
    int dist[MAX_NODES]; // Stores the minimum mutations to reach this gene
    bool visited[MAX_NODES];

    int front = 0;
    int rear = 0;

    for (int i = 0; i < num_all_genes; ++i) {
        dist[i] = -1; // -1 means not visited
        visited[i] = false;
    }

    // Enqueue startGene's index
    queue[rear++] = start_idx;
    dist[start_idx] = 0;
    visited[start_idx] = true;

    // BFS loop
    while (front < rear) {
        int curr_idx = queue[front++];
        int curr_dist = dist[curr_idx];

        // If we reached the endGene, return its distance
        if (curr_idx == end_idx) {
            return curr_dist;
        }

        // Explore neighbors
        for (int i = 0; i < num_all_genes; ++i) {
            // If gene 'i' has not been visited and differs by one mutation from current gene
            if (!visited[i] && differsByOne(all_genes[curr_idx], all_genes[i])) {
                visited[i] = true;
                dist[i] = curr_dist + 1;
                queue[rear++] = i;
            }
        }
    }

    // If the queue becomes empty and endGene was not reached
    return -1;
}