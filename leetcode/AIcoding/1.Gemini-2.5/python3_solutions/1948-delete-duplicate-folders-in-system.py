import collections

class Solution:
    def deleteDuplicateFolders(self, paths: list[list[str]]) -> list[list[str]]:
        # Step 1: Build the file system tree
        # Use a dictionary where keys are folder names and values are sub-dictionaries
        root_dict = {}
        for path in paths:
            current = root_dict
            for folder in path:
                current = current.setdefault(folder, {})

        # Global structures for DFS
        # Maps a subtree's serialization hash to a list of (parent_dict, folder_name) tuples
        # These tuples point to the folder instances that have this hash.
        hash_to_path_tuples = collections.defaultdict(list)
        # Set of hashes that have been identified as duplicates.
        # Any folder whose subtree hash is in this set should be deleted.
        deleted_hashes = set()

        # Step 2: Perform a post-order DFS to compute hashes and identify duplicates
        # This function computes the hash for the subtree rooted at current_dict.
        # It also updates hash_to_path_tuples and deleted_hashes, and performs deletions.
        # Returns the hash string if the current_dict is NOT deleted, otherwise returns an empty string.
        def dfs_process(current_dict: dict, parent_dict: dict, folder_name: str) -> str:
            # Recursively process children first (post-order traversal)
            children_hashes_list = []

            # Iterate over a sorted copy of keys to ensure canonical hash and safe modification
            # If a child is deleted, it's removed from current_dict.
            for name in sorted(list(current_dict.keys())):
                child_hash = dfs_process(current_dict[name], current_dict, name)
                if child_hash:  # If child_hash is not empty, it means the child was not deleted
                    children_hashes_list.append(name + "(" + child_hash + ")")

            # Form the hash for the current subtree
            # The hash is a string representation of its children's structure
            current_hash = "(" + ",".join(children_hashes_list) + ")"

            # Check if this hash represents a duplicate
            if current_hash in deleted_hashes:
                # This node (current_dict) itself is a duplicate, so it should be deleted.
                # Remove it from its parent.
                # The root_dict itself (parent of top-level folders) is never deleted.
                # Only delete if it's not the conceptual root of the entire file system (represented by root_dict)
                if parent_dict and folder_name: 
                    del parent_dict[folder_name]
                return "" # Indicate that this node was deleted

            if current_hash in hash_to_path_tuples:
                # This is the second (or more) instance of this hash.
                # Mark this hash as one that needs all its instances deleted.
                deleted_hashes.add(current_hash)

                # Delete all previously seen nodes with this hash.
                for prev_parent_dict, prev_folder_name in hash_to_path_tuples[current_hash]:
                    # Check if the folder still exists (might have been deleted by a parent deletion)
                    if prev_folder_name in prev_parent_dict:
                        del prev_parent_dict[prev_folder_name]

                # Also delete this current node.
                if parent_dict and folder_name:
                    del parent_dict[folder_name]
                return "" # Indicate that this node was deleted

            # If not a duplicate (first instance of this hash), record it.
            hash_to_path_tuples[current_hash].append((parent_dict, folder_name))

            return current_hash

        # Call the DFS for all top-level folders in root_dict.
        # Iterate over a copy of keys because children might be deleted.
        for name in sorted(list(root_dict.keys())):
            dfs_process(root_dict[name], root_dict, name)

        # Step 3: Reconstruct the paths of the remaining folders
        result_paths = []
        def dfs_reconstruct_paths(current_dict: dict, current_path_prefix: list[str]):
            for name in sorted(current_dict.keys()):
                new_path = current_path_prefix + [name]
                result_paths.append(new_path)
                dfs_reconstruct_paths(current_dict[name], new_path)

        dfs_reconstruct_paths(root_dict, [])

        return result_paths