int findKthPositive(int* arr, int arrSize, int k) {
    int current_positive_num = 1;
    int arr_index = 0;

    while (k > 0) {
        if (arr_index < arrSize && arr[arr_index] == current_positive_num) {
            arr_index++;
        } else {
            k--;
        }

        if (k == 0) {
            return current_positive_num;
        }

        current_positive_num++;
    }

    return -1; 
}