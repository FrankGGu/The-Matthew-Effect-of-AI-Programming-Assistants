impl Solution {
    pub fn find_latest_step(arr: Vec<i32>, m: i32) -> i32 {
        let n = arr.len();
        if m == n as i32 {
            return n as i32;
        }
        let mut parent = vec![0; n + 2];
        let mut size = vec![0; n + 2];
        let mut count = vec![0; n + 2];
        let mut res = -1;

        for step in 0..n {
            let pos = arr[step] as usize;
            parent[pos] = pos;
            size[pos] = 1;
            count[1] += 1;

            let left = pos - 1;
            if parent[left] != 0 {
                Self::union(&mut parent, &mut size, &mut count, left, pos);
            }

            let right = pos + 1;
            if parent[right] != 0 {
                Self::union(&mut parent, &mut size, &mut count, pos, right);
            }

            if count[m as usize] > 0 {
                res = step as i32 + 1;
            }
        }
        res
    }

    fn find(parent: &mut Vec<usize>, x: usize) -> usize {
        if parent[x] != x {
            parent[x] = Self::find(parent, parent[x]);
        }
        parent[x]
    }

    fn union(parent: &mut Vec<usize>, size: &mut Vec<i32>, count: &mut Vec<i32>, x: usize, y: usize) {
        let root_x = Self::find(parent, x);
        let root_y = Self::find(parent, y);
        if root_x == root_y {
            return;
        }
        count[size[root_x] as usize] -= 1;
        count[size[root_y] as usize] -= 1;
        size[root_y] += size[root_x];
        count[size[root_y] as usize] += 1;
        parent[root_x] = root_y;
    }
}