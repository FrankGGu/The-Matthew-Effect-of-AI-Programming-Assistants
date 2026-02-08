use std::collections::BinaryHeap;

impl Solution {
    pub fn schedule_course(courses: Vec<Vec<i32>>) -> i32 {
        let mut courses = courses;
        courses.sort_by(|a, b| a[1].cmp(&b[1]));
        let mut heap = BinaryHeap::new();
        let mut time = 0;
        for course in courses {
            let duration = course[0];
            let deadline = course[1];
            time += duration;
            heap.push(duration);
            if time > deadline {
                time -= heap.pop().unwrap();
            }
        }
        heap.len() as i32
    }
}