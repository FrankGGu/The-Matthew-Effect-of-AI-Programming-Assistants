var maximizeSquareArea = function(m, n, hFences, vFences) {
    const MOD = 10 ** 9 + 7;

    const h_coords_set = new Set([0, m + 1]);
    for (const fence of hFences) {
        h_coords_set.add(fence);
    }
    const sorted_h_coords = Array.from(h_coords_set).sort((a, b) => a - b);

    const v_coords_set = new Set([0, n + 1]);
    for (const fence of vFences) {
        v_coords_set.add(fence);
    }
    const sorted_v_coords = Array.from(v_coords_set).sort((a, b) => a - b);

    const h_diffs = new Set();
    for (let i = 0; i < sorted_h_coords.length; i++) {
        for (let j = i + 1; j < sorted_h_coords.length; j++) {
            h_diffs.add(sorted_h_coords[j] - sorted_h_coords[i]);
        }
    }

    let max_side = 0;
    for (let i = 0; i < sorted_v_coords.length; i++) {
        for (let j = i + 1; j < sorted_v_coords.length; j++) {
            const current_side = sorted_v_coords[j] - sorted_v_coords[i];
            if (h_diffs.has(current_side)) {
                max_side = Math.max(max_side, current_side);
            }
        }
    }

    if (max_side === 0) {
        return -1;
    }

    const area = (BigInt(max_side) * BigInt(max_side)) % BigInt(MOD);
    return Number(area);
};