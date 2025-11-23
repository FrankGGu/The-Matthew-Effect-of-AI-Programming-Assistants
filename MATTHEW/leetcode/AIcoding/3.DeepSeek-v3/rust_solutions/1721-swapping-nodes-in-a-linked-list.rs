impl Solution {
    pub fn swap_nodes(mut head: Option<Box<ListNode>>, k: i32) -> Option<Box<ListNode>> {
        let mut len = 0;
        let mut current = head.as_ref();
        while let Some(node) = current {
            len += 1;
            current = node.next.as_ref();
        }

        let k = k as usize;
        let k_from_end = len - k + 1;

        if k == k_from_end {
            return head;
        }

        let (first_pos, second_pos) = if k < k_from_end {
            (k, k_from_end)
        } else {
            (k_from_end, k)
        };

        let mut first_val = 0;
        let mut second_val = 0;
        let mut current = head.as_ref();
        let mut pos = 1;
        while let Some(node) = current {
            if pos == first_pos {
                first_val = node.val;
            }
            if pos == second_pos {
                second_val = node.val;
                break;
            }
            pos += 1;
            current = node.next.as_ref();
        }

        let mut current = head.as_mut();
        let mut pos = 1;
        while let Some(node) = current {
            if pos == first_pos {
                node.val = second_val;
            }
            if pos == second_pos {
                node.val = first_val;
                break;
            }
            pos += 1;
            current = node.next.as_mut();
        }

        head
    }
}