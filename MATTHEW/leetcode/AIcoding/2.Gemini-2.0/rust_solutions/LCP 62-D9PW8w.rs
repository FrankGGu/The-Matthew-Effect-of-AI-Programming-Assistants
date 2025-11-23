impl Solution {
    pub fn transportation_hub(path: Vec<Vec<i32>>) -> i32 {
        let mut max_node = 0;
        for p in &path {
            max_node = max_node.max(p[0]);
            max_node = max_node.max(p[1]);
        }
        max_node += 1;

        let mut in_degree = vec![0; max_node as usize];
        let mut out_degree = vec![0; max_node as usize];

        for p in &path {
            out_degree[p[0] as usize] += 1;
            in_degree[p[1] as usize] += 1;
        }

        let mut count = 0;
        for i in 0..max_node {
            if out_degree[i as usize] == 0 && in_degree[i as usize] == (path.len() as i32) {
                count += 1;
            }
        }

        if count == 1 {
            return 0;
        }

        let mut ans = -1;
        for i in 0..max_node {
            if out_degree[i as usize] == 0 && in_degree[i as usize] > 0 {
                let mut valid = true;
                for j in 0..max_node {
                    if i == j {
                        continue;
                    }
                    if out_degree[j as usize] > 0 && !path.iter().any(|&x| x[0] == j && x[1] == i) {
                        valid = false;
                        break;
                    }
                }

                if valid {
                    if ans == -1 {
                        ans = i;
                    } else {
                        return -1;
                    }
                }
            }
        }

        if ans != -1 {
            let mut in_count = 0;
            for p in &path {
                if p[1] == ans {
                    in_count += 1;
                }
            }
            if in_count == path.len() as i32 {
                return 0;
            } else {
                return -1;
            }
        }

        let mut ans = -1;
        for i in 0..max_node {
             if out_degree[i as usize] == 0 && in_degree[i as usize] > 0 {
                let mut valid = true;
                for j in 0..max_node {
                    if i == j {
                        continue;
                    }
                    if out_degree[j as usize] > 0 && !path.iter().any(|&x| x[0] == j && x[1] == i) {
                        valid = false;
                        break;
                    }
                }

                if valid {
                    if ans == -1 {
                        ans = i;
                    } else {
                        return -1;
                    }
                }
            }
        }

       if ans != -1{
            let mut in_count = 0;
            for p in &path {
                if p[1] == ans {
                    in_count += 1;
                }
            }
            if in_count == path.len() as i32 {
                return 0;
            } else {
                return -1;
            }
        }

        -1
    }
}