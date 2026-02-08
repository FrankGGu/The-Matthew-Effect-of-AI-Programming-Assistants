impl Solution {
    pub fn have_conflict(event1: Vec<String>, event2: Vec<String>) -> bool {
        let start1 = &event1[0];
        let end1 = &event1[1];
        let start2 = &event2[0];
        let end2 = &event2[1];

        !(end1 < start2 || end2 < start1)
    }
}