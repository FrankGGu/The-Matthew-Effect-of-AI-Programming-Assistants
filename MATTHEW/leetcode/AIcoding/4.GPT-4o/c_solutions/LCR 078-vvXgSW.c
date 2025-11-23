struct ListNode* mergeKLists(struct ListNode** lists, int listsSize) {
    if (listsSize == 0) return NULL;

    struct ListNode* result = NULL;
    struct ListNode** minHeap = (struct ListNode**)malloc(listsSize * sizeof(struct ListNode*));
    int heapSize = 0;

    for (int i = 0; i < listsSize; i++) {
        if (lists[i]) {
            minHeap[heapSize++] = lists[i];
        }
    }

    while (heapSize > 0) {
        struct ListNode* minNode = minHeap[0];
        minHeap[0] = minHeap[--heapSize];
        if (heapSize > 0) {
            // Heapify down
            int idx = 0;
            while (idx < heapSize) {
                int left = 2 * idx + 1;
                int right = 2 * idx + 2;
                int smallest = idx;

                if (left < heapSize && minHeap[left]->val < minHeap[smallest]->val) {
                    smallest = left;
                }
                if (right < heapSize && minHeap[right]->val < minHeap[smallest]->val) {
                    smallest = right;
                }
                if (smallest == idx) break;

                struct ListNode* temp = minHeap[idx];
                minHeap[idx] = minHeap[smallest];
                minHeap[smallest] = temp;
                idx = smallest;
            }
        }

        if (minNode->next) {
            minHeap[heapSize++] = minNode->next;
            // Heapify up
            int idx = heapSize - 1;
            while (idx > 0) {
                int parent = (idx - 1) / 2;
                if (minHeap[parent]->val <= minHeap[idx]->val) break;
                struct ListNode* temp = minHeap[parent];
                minHeap[parent] = minHeap[idx];
                minHeap[idx] = temp;
                idx = parent;
            }
        }

        minNode->next = result;
        result = minNode;
    }

    struct ListNode* prev = NULL;
    struct ListNode* current = result;
    while (current) {
        struct ListNode* next = current->next;
        current->next = prev;
        prev = current;
        current = next;
    }

    free(minHeap);
    return prev;
}