impl Solution {
    pub fn transform_array(arr: Vec<i32>) -> Vec<i32> {
        let mut current = arr.clone();
        let mut next = arr.clone();
        let mut changed = true;

        while changed {
            changed = false;
            for i in 1..(current.len() - 1) {
                if current[i - 1] > current[i] && current[i + 1] > current[i] {
                    next[i] = current[i] + 1;
                    changed = true;
                } else if current[i - 1] < current[i] && current[i + 1] < current[i] {
                    next[i] = current[i] - 1;
                    changed = true;
                } else {
                    next[i] = current[i];
                }
            }
            current = next.clone();
        }

        current
    }
}