impl Solution {
    pub fn relative_sort_array(arr1: Vec<i32>, arr2: Vec<i32>) -> Vec<i32> {
        let mut counts = vec![0; 1001];
        for &num in &arr1 {
            counts[num as usize] += 1;
        }

        let mut result = Vec::with_capacity(arr1.len());

        for &num in &arr2 {
            while counts[num as usize] > 0 {
                result.push(num);
                counts[num as usize] -= 1;
            }
        }

        for i in 0..=1000 {
            while counts[i] > 0 {
                result.push(i as i32);
                counts[i] -= 1;
            }
        }

        result
    }
}