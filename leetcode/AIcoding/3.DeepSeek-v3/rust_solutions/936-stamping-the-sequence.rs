impl Solution {
    pub fn moves_to_stamp(stamp: String, target: String) -> Vec<i32> {
        let stamp: Vec<char> = stamp.chars().collect();
        let mut target: Vec<char> = target.chars().collect();
        let m = stamp.len();
        let n = target.len();
        let mut res = Vec::new();
        let mut visited = vec![false; n];
        let mut stars = 0;

        while stars < n {
            let mut replaced = false;
            for i in 0..=n - m {
                if !visited[i] && Self::can_replace(&target[i..i + m], &stamp) {
                    stars += Self::replace(&mut target[i..i + m], m);
                    visited[i] = true;
                    res.push(i as i32);
                    replaced = true;
                    if stars == n {
                        break;
                    }
                }
            }
            if !replaced {
                return Vec::new();
            }
        }

        res.reverse();
        res
    }

    fn can_replace(target: &[char], stamp: &[char]) -> bool {
        for i in 0..stamp.len() {
            if target[i] != '*' && target[i] != stamp[i] {
                return false;
            }
        }
        true
    }

    fn replace(target: &mut [char], m: usize) -> usize {
        let mut count = 0;
        for i in 0..m {
            if target[i] != '*' {
                target[i] = '*';
                count += 1;
            }
        }
        count
    }
}