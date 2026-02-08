impl Solution {
    pub fn relative_sort_array(arr1: Vec<i32>, arr2: Vec<i32>) -> Vec<i32> {
        let mut count = vec![0; 1001];
        for &num in &arr1 {
            count[num as usize] += 1;
        }

        let mut result = Vec::new();
        for &num in &arr2 {
            result.extend(vec![num; count[num as usize]]);
            count[num as usize] = 0;
        }

        for i in 0..count.len() {
            if count[i] > 0 {
                result.extend(vec![i as i32; count[i]]);
            }
        }

        result
    }
}