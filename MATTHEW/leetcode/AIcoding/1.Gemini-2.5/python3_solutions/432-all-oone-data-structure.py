class Node:
    def __init__(self, count):
        self.count = count
        self.keys = set()
        self.prev = None
        self.next = None

class AllOne:

    def __init__(self):
        self.counts = {}  # key -> count
        self.freq_nodes = {} # count -> Node

        # Doubly linked list of Nodes, ordered by count
        self.head = Node(0) # Sentinel node
        self.tail = Node(0) # Sentinel node
        self.head.next = self.tail
        self.tail.prev = self.head

    def _remove_node(self, node):
        # Remove a node from the linked list
        node.prev.next = node.next
        node.next.prev = node.prev
        del self.freq_nodes[node.count]

    def _add_node_after(self, prev_node, new_node):
        # Insert new_node after prev_node
        new_node.prev = prev_node
        new_node.next = prev_node.next
        prev_node.next.prev = new_node
        prev_node.next = new_node
        self.freq_nodes[new_node.count] = new_node

    def inc(self, key: str) -> None:
        curr_count = self.counts.get(key, 0)
        new_count = curr_count + 1
        self.counts[key] = new_count

        # Determine the node *before* where the new_freq_node should be inserted.
        # This is either the current_freq_node (if it still holds other keys)
        # or its predecessor (if current_freq_node becomes empty and is removed)
        # or the head (if curr_count was 0).
        insert_after_node = self.head # Default for curr_count == 0

        if curr_count > 0:
            curr_freq_node = self.freq_nodes[curr_count]
            curr_freq_node.keys.remove(key)
            insert_after_node = curr_freq_node # Tentative insertion point

            if not curr_freq_node.keys: # If node becomes empty, remove it
                insert_after_node = curr_freq_node.prev # New insertion point is prev of removed node
                self._remove_node(curr_freq_node)

        # Add key to new frequency node
        if new_count in self.freq_nodes:
            self.freq_nodes[new_count].keys.add(key)
        else:
            # Create a new node for new_count and insert it
            new_freq_node = Node(new_count)
            new_freq_node.keys.add(key)
            self._add_node_after(insert_after_node, new_freq_node)

    def dec(self, key: str) -> None:
        if key not in self.counts:
            return

        curr_count = self.counts[key]
        new_count = curr_count - 1

        # The node for curr_count must exist because key is in self.counts
        curr_freq_node = self.freq_nodes[curr_count]
        curr_freq_node.keys.remove(key)

        # Determine the node *before* where the new_freq_node should be inserted.
        # This is the predecessor of curr_freq_node.
        insert_after_node = curr_freq_node.prev

        if not curr_freq_node.keys: # If node becomes empty, remove it
            self._remove_node(curr_freq_node)

        # Update counts and add key to new frequency node (if new_count > 0)
        if new_count > 0:
            self.counts[key] = new_count
            if new_count in self.freq_nodes:
                self.freq_nodes[new_count].keys.add(key)
            else:
                # Create a new node for new_count and insert it
                new_freq_node = Node(new_count)
                new_freq_node.keys.add(key)
                self._add_node_after(insert_after_node, new_freq_node)
        else: # new_count == 0
            del self.counts[key]

    def getMaxKey(self) -> str:
        if self.tail.prev == self.head: # List is empty
            return ""
        return next(iter(self.tail.prev.keys))

    def getMinKey(self) -> str:
        if self.head.next == self.tail: # List is empty
            return ""
        return next(iter(self.head.next.keys))