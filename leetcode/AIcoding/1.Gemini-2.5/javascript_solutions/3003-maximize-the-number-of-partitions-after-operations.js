var maxPartitionsAfterOperations = function(s) {
    const n = s.length;

    // dp_no_op[i] stores the maximum number of partitions for the prefix s[0...i-1] without any operation.
    const dp_no_op = new Array(n + 1).fill(0);
    // dp_one_op[i] stores the maximum number of partitions for the prefix s[0...i-1] with exactly one operation.
    const dp_one_op = new Array(n + 1).fill(0);

    // last_pos[char_code] stores the last index where 'char_code' was seen.
    const last_pos = new Array(26).fill(-1);
    // second_last_pos[char_code] stores the second last index where 'char_code' was seen.
    const second_last_pos = new Array(26).fill(-1);

    // current_max_last_pos tracks the latest index that would force a split if no operation is used.
    // It's the maximum of `last_pos[c]` for all characters `c` in the current segment.
    let current_max_last_pos = -1;
    // current_max_second_last_pos tracks the latest index that would force a split
    // even if one operation is used (i.e., it's the second duplicate in the segment).
    // It's the maximum of `second_last_pos[c]` for all characters `c` in the current segment.
    let current_max_second_last_pos = -1;

    for (let i = 1; i <= n; i++) {
        const char_idx = s.charCodeAt(i - 1) - 'a'.charCodeAt(0);

        // Update current_max_last_pos and current_max_second_last_pos based on the current character.
        // These variables effectively track the earliest possible start index for the current segment
        // to be unique (current_max_last_pos + 1) or unique with one op (current_max_second_last_pos + 1).
        current_max_last_pos = Math.max(current_max_last_pos, last_pos[char_idx]);
        current_max_second_last_pos = Math.max(current_max_second_last_pos, second_last_pos[char_idx]);

        // Calculate dp_no_op[i]:
        // A new partition starts after the latest conflicting character.
        // The segment s[current_max_last_pos + 1 ... i-1] is unique.
        // The number of partitions before this segment is dp_no_op[current_max_last_pos + 1].
        // Add 1 for the current unique segment.
        dp_no_op[i] = dp_no_op[current_max_last_pos + 1] + 1;

        // Calculate dp_one_op[i]:
        // We have two options for the operation:
        // Option 1: The operation was used in a previous segment (before current_max_last_pos + 1).
        //           The current segment s[current_max_last_pos + 1 ... i-1] must be unique.
        //           This contributes dp_one_op[current_max_last_pos + 1] + 1 partitions.
        // Option 2: The operation is used in the current segment s[current_max_second_last_pos + 1 ... i-1].
        //           This segment has at most one duplicate (which we fix with the operation).
        //           The segments before current_max_second_last_pos + 1 were formed without an operation.
        //           This contributes dp_no_op[current_max_second_last_pos + 1] + 1 partitions.
        dp_one_op[i] = Math.max(
            dp_one_op[current_max_last_pos + 1] + 1,
            dp_no_op[current_max_second_last_pos + 1] + 1
        );

        // Update last_pos and second_last_pos for the current character.
        second_last_pos[char_idx] = last_pos[char_idx];
        last_pos[char_idx] = i - 1;
    }

    // The maximum number of partitions is the maximum of partitions with no operation or with one operation for the entire string.
    return Math.max(dp_no_op[n], dp_one_op[n]);
};