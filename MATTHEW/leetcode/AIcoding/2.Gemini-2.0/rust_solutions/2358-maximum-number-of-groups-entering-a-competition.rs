impl Solution {
    pub fn maximum_number_of_groups(grades: Vec<i32>) -> i32 {
        let mut grades = grades;
        grades.sort();
        let mut count = 0;
        let mut sum = 0;
        let mut group_size = 1;
        for &grade in &grades {
            sum += grade;
            if sum >= group_size as i32 * (group_size as i32 + 1) / 2 {
                count += 1;
                group_size += 1;
            }
        }
        count
    }
}