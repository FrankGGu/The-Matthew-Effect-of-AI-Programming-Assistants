var strongest = function(radiuses) {
    let maxRadius = Math.max(...radiuses);
    return radiuses.indexOf(maxRadius);
};