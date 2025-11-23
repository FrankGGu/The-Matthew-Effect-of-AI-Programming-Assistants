#define MAX_SIZE 10000

typedef struct Block {
    size_t size;
    struct Block *next;
} Block;

Block *freeList = NULL;

void initAllocator() {
    freeList = (Block *)malloc(sizeof(Block) + MAX_SIZE);
    freeList->size = MAX_SIZE;
    freeList->next = NULL;
}

void* allocate(size_t size) {
    Block *current = freeList;
    Block *previous = NULL;

    while (current) {
        if (current->size >= size + sizeof(Block)) {
            if (current->size > size + sizeof(Block) + sizeof(Block)) {
                Block *newBlock = (Block *)((char *)current + sizeof(Block) + size);
                newBlock->size = current->size - size - sizeof(Block);
                newBlock->next = current->next;
                current->next = newBlock;
                current->size = size;
            }
            if (previous) {
                previous->next = current->next;
            } else {
                freeList = current->next;
            }
            return (char *)current + sizeof(Block);
        }
        previous = current;
        current = current->next;
    }
    return NULL;
}

void deallocate(void* ptr) {
    Block *block = (Block *)((char *)ptr - sizeof(Block));
    block->next = freeList;
    freeList = block;
}

void destroyAllocator() {
    free(freeList);
}