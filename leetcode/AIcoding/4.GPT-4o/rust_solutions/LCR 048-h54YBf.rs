use serde::{Deserialize, Serialize};
use serde_json::{self, Value};
use std::collections::VecDeque;

#[derive(Serialize, Deserialize, Debug)]
struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

struct Codec;

impl Codec {
    pub fn new() -> Self {
        Codec
    }

    pub fn serialize(&self, root: Option<Box<TreeNode>>) -> String {
        let mut result = Vec::new();
        let mut queue = VecDeque::new();
        queue.push_back(root);

        while !queue.is_empty() {
            let node = queue.pop_front();
            match node {
                Some(Some(n)) => {
                    result.push(n.val);
                    queue.push_back(n.left);
                    queue.push_back(n.right);
                }
                Some(None) => {
                    result.push(serde_json::Value::Null);
                }
                None => {}
            }
        }
        serde_json::to_string(&result).unwrap()
    }

    pub fn deserialize(&self, data: String) -> Option<Box<TreeNode>> {
        let values: Vec<Value> = serde_json::from_str(&data).unwrap();
        let mut queue = VecDeque::new();
        let mut index = 0;

        if values.is_empty() || values[0].is_null() {
            return None;
        }

        let root = Box::new(TreeNode {
            val: values[0].as_i64().unwrap() as i32,
            left: None,
            right: None,
        });
        queue.push_back(root.clone());
        index += 1;

        while !queue.is_empty() {
            if index >= values.len() {
                break;
            }
            let node = queue.pop_front().unwrap();

            if values[index].is_null() {
                node.left = None;
            } else {
                let left_node = Box::new(TreeNode {
                    val: values[index].as_i64().unwrap() as i32,
                    left: None,
                    right: None,
                });
                node.left = Some(left_node);
                queue.push_back(node.left.as_ref().unwrap().clone());
            }
            index += 1;

            if index >= values.len() {
                break;
            }
            if values[index].is_null() {
                node.right = None;
            } else {
                let right_node = Box::new(TreeNode {
                    val: values[index].as_i64().unwrap() as i32,
                    left: None,
                    right: None,
                });
                node.right = Some(right_node);
                queue.push_back(node.right.as_ref().unwrap().clone());
            }
            index += 1;
        }
        Some(root)
    }
}