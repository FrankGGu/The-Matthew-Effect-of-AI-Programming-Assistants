char nextGreatestLetter(char* letters, int lettersSize, char target) {
    int low = 0;
    int high = lettersSize - 1;
    char ans = letters[0];

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (letters[mid] > target) {
            ans = letters[mid];
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}