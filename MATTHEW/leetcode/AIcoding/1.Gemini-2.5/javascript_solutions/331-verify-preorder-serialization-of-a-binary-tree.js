var isValidSerialization = function(preorder) {
    let nodes = preorder.split(',');
    let degree = 1; // Represents available slots for children

    for (let i = 0; i < nodes.length; i++) {
        // Each node consumes one slot
        degree--;

        // If degree becomes negative, it means we've consumed more slots than available
        // This indicates an invalid serialization (e.g., a child without a parent slot)
        if (degree < 0) {
            return false;
        }

        // If the current node is not a null node ('#'), it provides two new slots for its children
        if (nodes[i] !== '#') {
            degree += 2;
        }
    }

    // After processing all nodes, a valid serialization must have exactly zero remaining slots.
    // This means all slots were perfectly filled.
    return degree === 0;
};