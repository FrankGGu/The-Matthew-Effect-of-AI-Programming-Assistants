use std::collections::BinaryHeap;

impl Solution {
    pub fn schedule_course(courses: Vec<Vec<i32>>) -> i32 {
        let mut courses = courses;
        courses.sort_by_key(|x| x[1]);
        let mut max_heap = BinaryHeap::new();
        let mut total_time = 0;

        for course in courses {
            total_time += course[0];
            max_heap.push(course[0]);

            if total_time > course[1] {
                total_time -= max_heap.pop().unwrap();
            }
        }

        max_heap.len() as i32
    }
}