impl Solution {
    pub fn min_array(numbers: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut right = numbers.len() - 1;

        while left < right {
            let mid = left + (right - left) / 2;

            if numbers[mid] > numbers[right] {
                left = mid + 1;
            } else if numbers[mid] < numbers[right] {
                right = mid;
            } else {
                right -= 1;
            }
        }

        numbers[left]
    }
}