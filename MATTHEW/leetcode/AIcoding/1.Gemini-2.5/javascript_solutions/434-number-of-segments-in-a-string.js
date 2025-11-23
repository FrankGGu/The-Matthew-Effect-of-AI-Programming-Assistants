var countSegments = function(s) {
    return s.split(' ').filter(word => word !== '').length;
};