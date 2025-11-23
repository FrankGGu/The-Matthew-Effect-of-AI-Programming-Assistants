struct Node {
    left: i32,
    right: i32,
    height: i32,
}

impl Node {
    fn new(left: i32, right: i32, height: i32) -> Self {
        Node {
            left,
            right,
            height,
        }
    }
}

impl Solution {
    pub fn falling_squares(positions: Vec<Vec<i32>>) -> Vec<i32> {
        let mut skyline: Vec<Node> = vec![];
        let mut heights: Vec<i32> = vec![];

        for pos in positions {
            let left = pos[0];
            let side = pos[1];
            let right = left + side;

            let mut height = 0;
            for node in &skyline {
                if left < node.right && right > node.left {
                    height = height.max(node.height);
                }
            }
            height += side;

            let mut new_skyline: Vec<Node> = vec![];
            let mut i = 0;
            while i < skyline.len() {
                let node = &skyline[i];
                if node.right <= left {
                    new_skyline.push(Node::new(node.left, node.right, node.height));
                } else if node.left >= right {
                    new_skyline.push(Node::new(node.left, node.right, node.height));
                } else {
                    if node.left < left {
                        new_skyline.push(Node::new(node.left, left, node.height));
                    }
                    if node.right > right {
                        new_skyline.push(Node::new(right, node.right, node.height));
                    }
                }
                i += 1;
            }

            new_skyline.push(Node::new(left, right, height));
            new_skyline.sort_by_key(|node| node.left);

            skyline = vec![];
            i = 0;
            while i < new_skyline.len() {
                let mut j = i + 1;
                while j < new_skyline.len() && new_skyline[i].right == new_skyline[j].left && new_skyline[i].height == new_skyline[j].height {
                    j += 1;
                }
                let new_node = Node::new(new_skyline[i].left, if j < new_skyline.len() && new_skyline[j-1].right == new_skyline[j].left { new_skyline[j-1].right } else { new_skyline[i].right }, new_skyline[i].height);
                skyline.push(new_node);
                i = j;
            }

            let mut max_height = 0;
            for node in &skyline {
                max_height = max_height.max(node.height);
            }
            heights.push(max_height);
        }

        heights
    }
}