impl Solution {
    pub fn max_elegance(items: Vec<Vec<i32>>, k: i32) -> i64 {
        let mut items = items;
        items.sort_by(|a, b| b[0].cmp(&a[0]));

        let mut sum = 0;
        let mut distinct = std::collections::HashSet::new();
        let mut extra = Vec::new();

        for i in 0..k as usize {
            sum += items[i][0] as i64;
            if !distinct.contains(&items[i][1]) {
                distinct.insert(items[i][1]);
            } else {
                extra.push(items[i]);
            }
        }

        let mut ans = sum + (distinct.len() as i64) * (distinct.len() as i64);

        for i in k as usize..items.len() {
            if !distinct.contains(&items[i][1]) {
                if extra.len() > 0 {
                    let last = extra.pop().unwrap();
                    if items[i][0] > last[0] {
                        sum = sum - last[0] as i64 + items[i][0] as i64;
                        distinct.insert(items[i][1]);
                        ans = std::cmp::max(ans, sum + (distinct.len() as i64) * (distinct.len() as i64));
                    }
                }
            }
        }

        ans
    }
}