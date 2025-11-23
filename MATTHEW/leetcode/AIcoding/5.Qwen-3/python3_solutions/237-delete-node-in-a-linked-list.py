class Solution:
    def deleteNode(self, node):
        """
        :type node: ListNode
        :rtype: void
        """
        node.val = node.next.val
        node.next = node.next.next