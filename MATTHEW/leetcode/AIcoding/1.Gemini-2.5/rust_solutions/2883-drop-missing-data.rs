pub struct Solution;
impl Solution {
    pub fn drop_missing_data(data: Vec<Vec<Option<i32>>>) -> Vec<Vec<i32>> {
        data.into_iter()
            .filter_map(|row| {
                let mut cleaned_row = Vec::with_capacity(row.len());
                for item_option in row {
                    if let Some(item) = item_option {
                        cleaned_row.push(item);
                    } else {
                        return None;
                    }
                }
                Some(cleaned_row)
            })
            .collect()
    }
}