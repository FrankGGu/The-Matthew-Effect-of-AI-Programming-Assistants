use serde::{Deserialize, Serialize};
use serde_json::{self, Value};

#[derive(Serialize, Deserialize, Debug)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct Codec;

impl Codec {
    pub fn serialize(root: Option<Box<TreeNode>>) -> String {
        serde_json::to_string(&root).unwrap()
    }

    pub fn deserialize(data: String) -> Option<Box<TreeNode>> {
        serde_json::from_str(&data).unwrap()
    }
}