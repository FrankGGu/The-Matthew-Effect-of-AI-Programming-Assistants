impl Solution {
    pub fn get_intersection_node(
        head_a: Option<Box<ListNode>>,
        head_b: Option<Box<ListNode>>,
    ) -> Option<Box<ListNode>> {
        let mut a = head_a.as_ref();
        let mut b = head_b.as_ref();

        if a.is_none() || b.is_none() {
            return None;
        }

        let mut a_ptr = head_a;
        let mut b_ptr = head_b;

        while !std::ptr::eq(a.unwrap() as *const _, b.unwrap() as *const _) {

            if a.unwrap().next.is_none() {
                a_ptr = b_ptr.clone();
                a = a_ptr.as_ref();
            } else {
                a = a.unwrap().next.as_ref();
            }

            if b.unwrap().next.is_none() {
                b_ptr = a_ptr.clone();
                b = b_ptr.as_ref();
            } else {
                b = b.unwrap().next.as_ref();
            }
        }

        return a_ptr;
    }
}