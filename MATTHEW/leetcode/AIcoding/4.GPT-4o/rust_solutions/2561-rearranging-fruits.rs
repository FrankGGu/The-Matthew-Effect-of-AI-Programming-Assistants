impl Solution {
    pub fn rearrange_fruits(fruits: Vec<i32>) -> Vec<i32> {
        let mut count = vec![0; 1001];
        for &fruit in &fruits {
            count[fruit as usize] += 1;
        }

        let mut result = Vec::new();
        let mut prev = -1;

        for _ in 0..fruits.len() {
            let mut idx = -1;
            for i in 0..count.len() {
                if count[i] > 0 && i != prev {
                    if idx == -1 || count[i] > count[idx as usize] {
                        idx = i as i32;
                    }
                }
            }

            if idx != -1 {
                result.push(idx);
                count[idx as usize] -= 1;
                prev = idx;
            }
        }

        result
    }
}