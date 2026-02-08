use serde::{Deserialize, Serialize};
use serde_json;

#[derive(Serialize, Deserialize)]
struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

struct Codec;

impl Codec {
    pub fn serialize(root: Option<Box<TreeNode>>) -> String {
        serde_json::to_string(&root).unwrap()
    }

    pub fn deserialize(data: String) -> Option<Box<TreeNode>> {
        serde_json::from_str(&data).unwrap()
    }
}