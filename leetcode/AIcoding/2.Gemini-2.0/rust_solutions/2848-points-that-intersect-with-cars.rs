impl Solution {
    pub fn number_of_points(nums: Vec<Vec<i32>>) -> i32 {
        let mut points = std::collections::HashSet::new();
        for car in nums {
            for i in car[0]..=car[1] {
                points.insert(i);
            }
        }
        points.len() as i32
    }
}