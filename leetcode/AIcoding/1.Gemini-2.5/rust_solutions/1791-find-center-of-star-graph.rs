impl Solution {
    pub fn find_center(edges: Vec<Vec<i32>>) -> i32 {
        let edge1 = &edges[0];
        let edge2 = &edges[1];

        if edge1[0] == edge2[0] || edge1[0] == edge2[1] {
            edge1[0]
        } else {
            edge1[1]
        }
    }
}