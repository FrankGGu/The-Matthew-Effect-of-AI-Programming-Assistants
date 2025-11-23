impl Solution {
    pub fn maximum_beauty(items: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let mut items = items;
        items.sort_by(|a, b| a[0].cmp(&b[0]));

        let mut max_beauty = 0;
        for item in &mut items {
            max_beauty = max_beauty.max(item[1]);
            item[1] = max_beauty;
        }

        let mut result = Vec::new();
        for query in queries {
            let mut left = 0;
            let mut right = items.len();
            let mut beauty = 0;

            while left < right {
                let mid = left + (right - left) / 2;
                if items[mid][0] <= query {
                    beauty = items[mid][1];
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            result.push(beauty);
        }

        result
    }
}