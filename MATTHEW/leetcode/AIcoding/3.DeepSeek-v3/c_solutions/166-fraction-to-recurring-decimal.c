#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define HASH_SIZE 10000

typedef struct Node {
    long key;
    int value;
    struct Node* next;
} Node;

typedef struct {
    Node* buckets[HASH_SIZE];
} HashMap;

HashMap* createHashMap() {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    for (int i = 0; i < HASH_SIZE; i++) {
        map->buckets[i] = NULL;
    }
    return map;
}

void put(HashMap* map, long key, int value) {
    int index = labs(key) % HASH_SIZE;
    Node* node = map->buckets[index];
    while (node) {
        if (node->key == key) {
            node->value = value;
            return;
        }
        node = node->next;
    }
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->value = value;
    newNode->next = map->buckets[index];
    map->buckets[index] = newNode;
}

int get(HashMap* map, long key) {
    int index = labs(key) % HASH_SIZE;
    Node* node = map->buckets[index];
    while (node) {
        if (node->key == key) {
            return node->value;
        }
        node = node->next;
    }
    return -1;
}

void freeHashMap(HashMap* map) {
    for (int i = 0; i < HASH_SIZE; i++) {
        Node* node = map->buckets[i];
        while (node) {
            Node* temp = node;
            node = node->next;
            free(temp);
        }
    }
    free(map);
}

char* fractionToDecimal(int numerator, int denominator) {
    if (numerator == 0) return "0";

    char* result = (char*)malloc(10000 * sizeof(char));
    int index = 0;

    long num = labs((long)numerator);
    long den = labs((long)denominator);

    if ((numerator < 0) ^ (denominator < 0)) {
        result[index++] = '-';
    }

    long integerPart = num / den;
    long remainder = num % den;

    char intBuf[20];
    sprintf(intBuf, "%ld", integerPart);
    int len = strlen(intBuf);
    strcpy(result + index, intBuf);
    index += len;

    if (remainder == 0) {
        return result;
    }

    result[index++] = '.';

    HashMap* map = createHashMap();
    int repeatStart = -1;

    while (remainder != 0) {
        remainder *= 10;
        if (get(map, remainder) != -1) {
            repeatStart = get(map, remainder);
            break;
        }
        put(map, remainder, index);
        long digit = remainder / den;
        result[index++] = '0' + digit;
        remainder %= den;
    }

    if (repeatStart != -1) {
        result[index++] = ')';
        for (int i = index - 1; i > repeatStart; i--) {
            result[i] = result[i - 1];
        }
        result[repeatStart] = '(';
        result[index] = '\0';
    } else {
        result[index] = '\0';
    }

    freeHashMap(map);
    return result;
}