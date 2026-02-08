impl Solution {
    pub fn full_bloom_flowers(flowers: Vec<Vec<i32>>, people: Vec<i32>) -> Vec<i32> {
        let mut start_times: Vec<i32> = flowers.iter().map(|f| f[0]).collect();
        let mut end_times: Vec<i32> = flowers.iter().map(|f| f[1] + 1).collect();
        start_times.sort();
        end_times.sort();

        let mut result: Vec<i32> = Vec::new();
        for person in &people {
            let started = Self::upper_bound(&start_times, *person);
            let ended = Self::upper_bound(&end_times, *person);
            result.push(started as i32 - ended as i32);
        }
        result
    }

    fn upper_bound(arr: &Vec<i32>, target: i32) -> usize {
        let mut low = 0;
        let mut high = arr.len();
        while low < high {
            let mid = low + (high - low) / 2;
            if arr[mid] <= target {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        low
    }
}