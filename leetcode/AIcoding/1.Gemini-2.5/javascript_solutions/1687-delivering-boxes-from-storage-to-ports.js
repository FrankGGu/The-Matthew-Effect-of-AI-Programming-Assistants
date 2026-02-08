var deliverBoxes = function(boxes, portsCount, maxBoxes, maxWeight, maxPorts) {
    const n = boxes.length;

    // dp[i] will store the minimum trips to deliver the first i boxes (boxes[0]...boxes[i-1])
    const dp = new Array(n + 1).fill(0);

    // Calculate prefix sums for weights to efficiently get sum of weights in a range
    const weightPrefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        weightPrefixSum[i + 1] = weightPrefixSum[i] + boxes[i][1];
    }

    // j_weight_boxes: left pointer for maxBoxes and maxWeight constraints
    // This pointer defines the minimum starting index `j` such that `boxes[j...i-1]`
    // satisfies the `maxBoxes` and `maxWeight` constraints.
    let j_weight_boxes = 0;

    // j_ports: left pointer for maxPorts constraint
    // This pointer defines the minimum starting index `j` such that `boxes[j...i-1]`
    // satisfies the `maxPorts` constraint.
    let j_ports = 0;
    const portCounts = new Map(); // Frequency map for ports in the window [j_ports, i-1]
    let distinctPortsCount = 0;

    // Deque to maintain indices `k` such that `dp[k]` values are monotonically increasing.
    // This allows efficient retrieval of `min(dp[j])` in a sliding window.
    const deque = [0]; // dp[0] = 0 is the base case, representing 0 trips for 0 boxes

    for (let i = 1; i <= n; i++) {
        // Adjust j_weight_boxes to satisfy maxBoxes and maxWeight for a trip ending at i-1
        // The trip is considered for boxes[j_weight_boxes ... i-1]
        while (i - j_weight_boxes > maxBoxes || weightPrefixSum[i] - weightPrefixSum[j_weight_boxes] > maxWeight) {
            j_weight_boxes++;
        }

        // Adjust j_ports to satisfy maxPorts for a trip ending at i-1
        // Add boxes[i-1] to the window [j_ports, i-1] for port counting
        const currentPort = boxes[i - 1][0];
        portCounts.set(currentPort, (portCounts.get(currentPort) || 0) + 1);
        if (portCounts.get(currentPort) === 1) {
            distinctPortsCount++;
        }

        // Shrink the window from the left if maxPorts is exceeded
        while (distinctPortsCount > maxPorts) {
            const portToRemove = boxes[j_ports][0];
            portCounts.set(portToRemove, portCounts.get(portToRemove) - 1);
            if (portCounts.get(portToRemove) === 0) {
                distinctPortsCount--;
            }
            j_ports++;
        }

        // minJForTrip is the leftmost valid starting index for a trip ending at i-1.
        // It must satisfy all three constraints: maxBoxes, maxWeight, and maxPorts.
        const minJForTrip = Math.max(j_weight_boxes, j_ports);

        // Remove indices from the front of the deque that are no longer valid.
        // An index `k` is valid if `k >= minJForTrip`.
        while (deque.length > 0 && deque[0] < minJForTrip) {
            deque.shift();
        }

        // dp[i] is calculated using the minimum dp value from the valid range in the deque.
        // The cost of adding a new trip is 1.
        dp[i] = dp[deque[0]] + 1;

        // Add current index `i` to the deque for future calculations.
        // Maintain the property that dp values for indices in the deque are monotonically increasing.
        // This ensures deque[0] always points to the minimum dp value in the current valid window.
        while (deque.length > 0 && dp[deque[deque.length - 1]] >= dp[i]) {
            deque.pop();
        }
        deque.push(i);
    }

    return dp[n];
};