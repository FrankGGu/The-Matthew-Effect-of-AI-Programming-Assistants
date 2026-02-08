var stringCount = function(n) {
    const MOD = 10**9 + 7;
    let total = BigInt(26) ** BigInt(n);
    let noL = BigInt(25) ** BigInt(n);
    let noE = BigInt(25) ** BigInt(n);
    let noT = BigInt(25) ** BigInt(n);
    let noLE = BigInt(24) ** BigInt(n);
    let noLT = BigInt(24) ** BigInt(n);
    let noET = BigInt(24) ** BigInt(n);
    let noLET = BigInt(23) ** BigInt(n);

    let result = total - noL - noE - noT + noLE + noLT + noET - noLET;

    return Number(result % BigInt(MOD));
};