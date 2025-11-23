int findBound(int* scores, int scoresSize, int target, int findLowerBound) {
    int left = 0;
    int right = scoresSize - 1;
    int ans = scoresSize; // Default: if no element satisfies, return scoresSize

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (scores[mid] > target || (findLowerBound && scores[mid] == target)) {
            // This element or elements to its left might be the answer.
            // If scores[mid] is greater than target, or if we are looking for lower bound
            // and scores[mid] is equal to target, then mid is a potential answer.
            // We try to find an even earlier one by searching in the left half.
            ans = mid;
            right = mid - 1;
        } else {
            // This element is too small, or equal but we need strictly greater.
            // We need to search in the right half.
            left = mid + 1;
        }
    }
    return ans;
}

int countTarget(int* scores, int scoresSize, int target) {
    // Find the index of the first element that is >= target (lower bound)
    int firstOccurrence = findBound(scores, scoresSize, target, 1);

    // Find the index of the first element that is > target (upper bound)
    int firstGreaterThanTarget = findBound(scores, scoresSize, target, 0);

    // The count is the difference between these two indices.
    // If target is not present, both indices will be the same, resulting in a count of 0.
    return firstGreaterThanTarget - firstOccurrence;
}