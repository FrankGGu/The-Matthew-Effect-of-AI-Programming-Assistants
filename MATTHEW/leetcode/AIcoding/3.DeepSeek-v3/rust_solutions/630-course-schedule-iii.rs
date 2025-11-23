use std::collections::BinaryHeap;

impl Solution {
    pub fn schedule_course(courses: Vec<Vec<i32>>) -> i32 {
        let mut courses = courses;
        courses.sort_by(|a, b| a[1].cmp(&b[1]));

        let mut heap = BinaryHeap::new();
        let mut total = 0;

        for course in courses {
            let duration = course[0];
            let end = course[1];

            if total + duration <= end {
                heap.push(duration);
                total += duration;
            } else if !heap.is_empty() && *heap.peek().unwrap() > duration {
                total += duration - heap.pop().unwrap();
                heap.push(duration);
            }
        }

        heap.len() as i32
    }
}