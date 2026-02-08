import java.util.HashMap;

public class Solution {
    private int preIndex = 0;
    private HashMap<Integer, Integer> postIndexMap;

    public TreeNode constructFromPrePost(int[] pre, int[] post) {
        postIndexMap = new HashMap<>();
        for (int i = 0; i < post.length; i++) {
            postIndexMap.put(post[i], i);
        }
        return construct(pre, post, 0, post.length - 1);
    }

    private TreeNode construct(int[] pre, int[] post, int postStart, int postEnd) {
        if (postStart > postEnd) return null;
        TreeNode root = new TreeNode(pre[preIndex++]);
        if (postStart == postEnd || preIndex == pre.length) return root;

        int leftChildIndex = postIndexMap.get(pre[preIndex]);
        root.left = construct(pre, post, postStart, leftChildIndex);
        root.right = construct(pre, post, leftChildIndex + 1, postEnd - 1);

        return root;
    }
}