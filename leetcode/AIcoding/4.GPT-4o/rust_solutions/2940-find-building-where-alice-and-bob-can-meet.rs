impl Solution {
    pub fn find_building(n: i32, A: Vec<i32>, B: Vec<i32>) -> i32 {
        let mut building = -1;
        let mut max_height = 0;

        for &a in &A {
            max_height = max_height.max(a);
        }

        for &b in &B {
            max_height = max_height.max(b);
        }

        for i in 1..=n {
            if A.contains(&(i - 1)) && B.contains(&(i - 1)) {
                building = i;
                break;
            }
        }

        building
    }
}