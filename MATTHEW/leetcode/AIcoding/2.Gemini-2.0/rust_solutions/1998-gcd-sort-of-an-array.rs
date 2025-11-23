impl Solution {
    pub fn gcd_sort(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let max_num = *nums.iter().max().unwrap() as usize;
        let mut parent = (0..=max_num).collect::<Vec<usize>>();
        let mut size = vec![1; max_num + 1];

        fn find(parent: &mut Vec<usize>, i: usize) -> usize {
            if parent[i] == i {
                return i;
            }
            parent[i] = find(parent, parent[i]);
            parent[i]
        }

        fn union(parent: &mut Vec<usize>, size: &mut Vec<i32>, mut i: usize, mut j: usize) {
            i = find(parent, i);
            j = find(parent, j);

            if i != j {
                if size[i] < size[j] {
                    std::mem::swap(&mut i, &mut j);
                }

                parent[j] = i;
                size[i] += size[j];
            }
        }

        for &num in &nums {
            let mut x = num as usize;
            for i in 2..=((x as f64).sqrt() as usize) + 1 {
                if x % i == 0 {
                    union(&mut parent, &mut size, x, i);
                    while x % i == 0 {
                        x /= i;
                    }
                }
            }
            if x > 1 {
                union(&mut parent, &mut size, num as usize, x);
            }
        }

        let mut sorted_nums = nums.clone();
        sorted_nums.sort_unstable();

        for i in 0..n {
            if find(&mut parent, nums[i] as usize) != find(&mut parent, sorted_nums[i] as usize) {
                return false;
            }
        }

        true
    }
}