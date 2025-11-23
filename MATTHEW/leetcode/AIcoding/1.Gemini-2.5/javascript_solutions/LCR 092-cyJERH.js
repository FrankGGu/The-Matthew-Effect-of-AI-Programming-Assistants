var minFlipsMonoIncr = function(s) {
    let dp0 = 0; // min flips to make s[0...i] monotone increasing and end with '0'
    let dp1 = 0; // min flips to make s[0...i] monotone increasing and end with '1'

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        let new_dp0;
        let new_dp1;

        if (char === '0') {
            // If current char is '0':
            // To end with '0': no flip needed for current char. Cost is same as previous dp0.
            new_dp0 = dp0;
            // To end with '1': current char '0' must be flipped to '1'. Cost is min(previous dp0, previous dp1) + 1.
            new_dp1 = Math.min(dp0, dp1) + 1;
        } else { // char === '1'
            // If current char is '1':
            // To end with '0': current char '1' must be flipped to '0'. Cost is previous dp0 + 1.
            new_dp0 = dp0 + 1;
            // To end with '1': no flip needed for current char. Cost is min(previous dp0, previous dp1).
            new_dp1 = Math.min(dp0, dp1);
        }

        dp0 = new_dp0;
        dp1 = new_dp1;
    }

    // The minimum flips will be the minimum of ending with '0' or ending with '1' for the entire string.
    return Math.min(dp0, dp1);
};