impl Solution {
    pub fn valid_mountain_array(arr: Vec<i32>) -> bool {
        let n = arr.len();
        if n < 3 {
            return false;
        }

        let mut i = 0;

        // Walk up the mountain
        while i + 1 < n && arr[i] < arr[i + 1] {
            i += 1;
        }

        // A peak must exist and cannot be the first or last element
        if i == 0 || i == n - 1 {
            return false;
        }

        // Walk down the mountain
        while i + 1 < n && arr[i] > arr[i + 1] {
            i += 1;
        }

        // If we reached the end of the array, it's a valid mountain
        i == n - 1
    }
}