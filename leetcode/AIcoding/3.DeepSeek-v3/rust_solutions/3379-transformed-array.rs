impl Solution {
    pub fn transform_array(arr: Vec<i32>) -> Vec<i32> {
        let mut changed = true;
        let mut current = arr.clone();
        while changed {
            changed = false;
            let mut next = current.clone();
            for i in 1..current.len() - 1 {
                if current[i] > current[i - 1] && current[i] > current[i + 1] {
                    next[i] -= 1;
                    changed = true;
                } else if current[i] < current[i - 1] && current[i] < current[i + 1] {
                    next[i] += 1;
                    changed = true;
                }
            }
            current = next;
        }
        current
    }
}