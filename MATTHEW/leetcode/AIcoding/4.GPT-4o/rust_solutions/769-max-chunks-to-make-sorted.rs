impl Solution {
    pub fn max_chunks_to_sorted(arr: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut max_so_far = 0;

        for (i, num) in arr.iter().enumerate() {
            max_so_far = max_so_far.max(*num);
            if max_so_far == i as i32 {
                count += 1;
            }
        }

        count
    }
}