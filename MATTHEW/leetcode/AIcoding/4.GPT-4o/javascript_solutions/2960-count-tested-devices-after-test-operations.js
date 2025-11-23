function countDevices(devices, tests) {
    const tested = new Set();
    for (const test of tests) {
        for (const device of test) {
            tested.add(device);
        }
    }
    return devices.filter(device => tested.has(device)).length;
}