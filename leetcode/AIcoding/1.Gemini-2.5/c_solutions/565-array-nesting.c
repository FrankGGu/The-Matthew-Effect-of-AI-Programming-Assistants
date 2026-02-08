int arrayNesting(int* nums, int numsSize) {
    int maxLength = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != -1) { // If the element has not been visited yet
            int currentLength = 0;
            int currentNode = i; // Start traversal from the current index

            while (nums[currentNode] != -1) { // Continue while the current element points to an unvisited element
                int nextNode = nums[currentNode]; // Get the next element in the sequence
                nums[currentNode] = -1; // Mark the current element as visited by setting it to -1
                currentNode = nextNode; // Move to the next element
                currentLength++; // Increment the length of the current set
            }

            if (currentLength > maxLength) {
                maxLength = currentLength;
            }
        }
    }

    return maxLength;
}