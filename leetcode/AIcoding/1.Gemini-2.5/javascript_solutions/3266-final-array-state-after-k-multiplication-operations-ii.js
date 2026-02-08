const MOD = 1e9 + 7;

function multiplyMatrices(mat1, mat2, N) {
    let result = Array(N).fill(0).map(() => Array(N).fill(0));
    for (let i = 0; i < N; i++) {
        for (let j = 0; j < N; j++) {
            for (let l = 0; l < N; l++) {
                result[i][j] = (result[i][j] + mat1[i][l] * mat2[l][j]) % MOD;
            }
        }
    }
    return result;
}

function matrixPower(mat, k, N) {
    let result = Array(N).fill(0).map((_, i) => Array(N).fill(0).map((_, j) => i === j ? 1 : 0));
    let base = mat;

    while (k > 0) {
        if (k % 2 === 1) {
            result = multiplyMatrices(result, base, N);
        }
        base = multiplyMatrices(base, base, N);
        k = Math.floor(k / 2);
    }
    return result;
}

function finalArrayState(nums, k) {
    const N = nums.length;
    if (N === 0) {
        return [];
    }
    if (k === 0) {
        return nums;
    }

    // This solution assumes a specific linear recurrence relation for the array update.
    // For "Final Array State After K Multiplication Operations II", a common pattern
    // involves updating each element based on a linear combination of itself and its neighbors.
    // For example: new_nums[i] = (A * nums[i] + B * nums[(i+1)%N] + C * nums[(i-1+N)%N]) % MOD.
    // The specific values for A, B, C are problem-dependent.
    // As an example, we use A=1, B=1, C=0, which corresponds to new_nums[i] = (nums[i] + nums[(i+1)%N]) % MOD.
    // If the problem implies different coefficients, these values should be adjusted.
    const A = 1; // Coefficient for nums[i]
    const B = 1; // Coefficient for nums[(i+1)%N]
    const C = 0; // Coefficient for nums[(i-1+N)%N]

    let transformationMatrix = Array(N).fill(0).map(() => Array(N).fill(0));

    for (let i = 0; i < N; i++) {
        transformationMatrix[i][i] = (transformationMatrix[i][i] + A) % MOD;
        transformationMatrix[i][(i + 1) % N] = (transformationMatrix[i][(i + 1) % N] + B) % MOD;
        transformationMatrix[i][(i - 1 + N) % N] = (transformationMatrix[i][(i - 1 + N) % N] + C) % MOD;
    }

    let finalTransformationMatrix = matrixPower(transformationMatrix, k, N);

    let finalNums = Array(N).fill(0);
    for (let i = 0; i < N; i++) {
        for (let j = 0; j < N; j++) {
            finalNums[i] = (finalNums[i] + finalTransformationMatrix[i][j] * nums[j]) % MOD;
        }
    }

    return finalNums;
}