int maximumSum(int* arr, int arrSize) {
    int max_sum = 0;
    int current_sum = 0;
    int total_sum = 0;
    int max_element = arr[0];
    int freq[100001] = {0};

    for (int i = 0; i < arrSize; i++) {
        total_sum += arr[i];
        if (arr[i] > max_element) {
            max_element = arr[i];
        }
        freq[arr[i]]++;
    }

    for (int i = 0; i < arrSize; i++) {
        current_sum += arr[i];
        if (current_sum < 0) {
            current_sum = 0;
        }
        max_sum = (current_sum > max_sum) ? current_sum : max_sum;
    }

    for (int i = 0; i < arrSize; i++) {
        if (arr[i] == max_element) {
            int temp_sum = total_sum - max_element;
            if (temp_sum > max_sum) {
                max_sum = temp_sum;
            }
            break;
        }
    }

    return max_sum;
}