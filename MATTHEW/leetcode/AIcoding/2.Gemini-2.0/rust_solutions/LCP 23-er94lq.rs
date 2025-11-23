impl Solution {
    pub fn is_magic(target: Vec<i32>) -> bool {
        let n = target.len();
        if n == 1 {
            return true;
        }

        if n % 2 == 0 {
            return false;
        }

        let mut arr: Vec<i32> = (1..=n as i32).collect();
        let mut current = arr.clone();
        let mut count = 0;

        while current != target && count < 100 {
            let mut next = vec![0; n];
            let mid = (n + 1) / 2;
            let mut j = 0;
            for i in 1..mid {
                next[j] = current[i];
                j += 1;
            }
            for i in 0..mid {
                next[j] = current[i];
                j += 1;
            }

            current = next;
            count += 1;
        }

        current == target
    }
}