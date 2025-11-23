impl Solution {
    pub fn find_length_of_shortest_subarray(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut left = 0;
        let mut right = n as i32 - 1;

        while left < n - 1 && arr[left] <= arr[left + 1] {
            left += 1;
        }

        if left == n - 1 {
            return 0;
        }

        while right > 0 && arr[right as usize] >= arr[right as usize - 1] {
            right -= 1;
        }

        let mut min_length = right + 1;

        for i in 0..=left {
            while right < n as i32 && arr[i] > arr[right as usize] {
                right += 1;
            }
            min_length = min_length.min(right - i - 1);
        }

        min_length as i32
    }
}