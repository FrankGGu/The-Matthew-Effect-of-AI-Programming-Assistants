var minOperations = function(num1, num2) {
    if (num1 === num2) return 0;

    const digits1 = new Set(String(num1).split(''));
    const digits2 = new Set(String(num2).split(''));

    const intersect = [...digits1].filter(d => digits2.has(d)).length;
    const totalUniqueDigits = new Set([...digits1, ...digits2]).size;

    return totalUniqueDigits - intersect;
};