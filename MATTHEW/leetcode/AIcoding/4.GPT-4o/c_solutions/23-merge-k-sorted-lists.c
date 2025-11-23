struct ListNode* mergeKLists(struct ListNode** lists, int listsSize) {
    if (listsSize == 0) return NULL;

    struct ListNode* mergedList = NULL;
    struct ListNode** minHeap = malloc(listsSize * sizeof(struct ListNode*));
    int heapSize = 0;

    for (int i = 0; i < listsSize; i++) {
        if (lists[i]) {
            minHeap[heapSize++] = lists[i];
        }
    }

    while (heapSize > 0) {
        struct ListNode* minNode = minHeap[0];
        minHeap[0] = minHeap[--heapSize];
        if (minHeapSize > 0) {
            minHeapify(minHeap, heapSize, 0);
        }

        if (mergedList == NULL) {
            mergedList = minNode;
        } else {
            mergedList->next = minNode;
        }

        if (minNode->next) {
            minHeap[heapSize++] = minNode->next;
            heapifyUp(minHeap, heapSize - 1);
        }

        mergedList = minNode;
    }

    free(minHeap);
    return mergedList;
}

void minHeapify(struct ListNode** heap, int heapSize, int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heapSize && heap[left]->val < heap[smallest]->val) {
        smallest = left;
    }

    if (right < heapSize && heap[right]->val < heap[smallest]->val) {
        smallest = right;
    }

    if (smallest != index) {
        struct ListNode* temp = heap[index];
        heap[index] = heap[smallest];
        heap[smallest] = temp;
        minHeapify(heap, heapSize, smallest);
    }
}

void heapifyUp(struct ListNode** heap, int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (heap[index]->val >= heap[parent]->val) break;
        struct ListNode* temp = heap[index];
        heap[index] = heap[parent];
        heap[parent] = temp;
        index = parent;
    }
}