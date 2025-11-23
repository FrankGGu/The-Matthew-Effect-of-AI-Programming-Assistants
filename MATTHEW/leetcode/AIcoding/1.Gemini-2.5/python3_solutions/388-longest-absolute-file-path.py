class Solution:
    def lengthLongestPath(self, input: str) -> int:
        max_len = 0
        # path_lengths[depth] stores the length of the path up to the directory at 'depth-1',
        # including the directory name and a trailing slash,
        # ready for the next item at 'depth'.
        # For example, path_lengths[1] stores len("dir/")
        # path_lengths[0] is 0, representing the root level with no length.
        path_lengths = {0: 0} 

        for line in input.split('\n'):
            name = line.lstrip('\t')
            depth = len(line) - len(name) # Count of '\t' characters

            # current_path_len is the length of the path up to the current item,
            # including its name, but without a trailing slash.
            # Example: "dir/subdir/file.txt" -> length of "dir/subdir/" + len("file.txt")
            # path_lengths[depth] gives len("dir/subdir/")
            current_path_len = path_lengths[depth] + len(name)

            if '.' in name: # It's a file
                max_len = max(max_len, current_path_len)
            else: # It's a directory
                # Store the length for items at the next depth.
                # This includes the current directory's name and a trailing slash.
                # Example: for "dir/subdir", we store len("dir/subdir/") at path_lengths[depth + 1]
                path_lengths[depth + 1] = current_path_len + 1

        return max_len